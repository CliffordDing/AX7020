/*
 * Copyright (c) 2014, Mentor Graphics Corporation
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. Neither the name of Mentor Graphics Corporation nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef PLATFORM_H_
#define PLATFORM_H_

#include <stdio.h>
#include <source/hil.h>

/* ------------------------- Macros --------------------------*/
#define ESAL_DP_SLCR_BASE                  0xF8000000
#define PERIPH_BASE                        0xF8F00000
#define GIC_DIST_BASE                      (PERIPH_BASE + 0x00001000)
#define GIC_DIST_SOFTINT                   0xF00
#define GIC_SFI_TRIG_CPU_MASK              0x00FF0000
#define GIC_SFI_TRIG_SATT_MASK             0x00008000
#define GIC_SFI_TRIG_INTID_MASK            0x0000000F
#define GIC_CPU_ID_BASE                    (1 << 4)
#define A9_CPU_SLCR_RESET_CTRL             0x244
#define A9_CPU_SLCR_CLK_STOP               (1 << 4)
#define A9_CPU_SLCR_RST                    (1 << 0)

#define unlock_slcr()                       HIL_MEM_WRITE32(ESAL_DP_SLCR_BASE + 0x08, 0xDF0DDF0D)
#define lock_slcr()                         HIL_MEM_WRITE32(ESAL_DP_SLCR_BASE + 0x04, 0x767B767B)


/* L2Cpl310 L2 cache controller base address. */
#define         HIL_PL130_BASE              0xF8F02000

/********************/
/* Register offsets */
/********************/

#define         HIL_PL130_INVALLINE         0x770
#define         HIL_PL130_CLEANINVLINE      0x7F0


#define         HIL_PA_SBZ_MASK             ~(HIL_CACHE_LINE_SIZE - 1UL)
#define         HIL_CACHE_LINE_SIZE         32
#define         HIL_CACHE_INV_ALL_WAYS      0xFF
#define         HIL_CACHE_UNLOCK_ALL_WAYS   0xFFFF0000
#define         HIL_CACHE_CLEAR_INT         0x1FF


/* This macro invalidates all Data cache for the specified address
   range at the processor level. */
#define         HIL_L2CACHE_INVALIDATE(addr, size)                                                           \
                {                                                                                                 \
                                                                                                                  \
                    unsigned int  addr_v     = (unsigned int)addr & HIL_PA_SBZ_MASK;                        \
                    unsigned int  l_size     = 0;                                                                 \
                    unsigned int  align_size = ((unsigned int)size + ((unsigned int)addr &                        \
                                          (HIL_CACHE_LINE_SIZE-1UL)));                                      \
                                                                                                                  \
                    do                                                                                            \
                    {                                                                                             \
                        /* Invalidate cache line by PA. */                                                        \
                        HIL_MEM_WRITE32(HIL_PL130_BASE + HIL_PL130_INVALLINE, addr_v);            \
                                                                                                                  \
                        /* Move to the next way */                                                                \
                        addr_v += HIL_CACHE_LINE_SIZE;                                                      \
                        l_size += HIL_CACHE_LINE_SIZE;                                                      \
                                                                                                                  \
                    } while (l_size < align_size);                                                                \
                }


/* This macro flushes all data cache to physical memory (writeback cache)
   for the given address range, then invalidates all data cache entries
   at the processor level. */
#define         HIL_L2CACHE_FLUSH_INVAL(addr, size)                                                          \
                {                                                                                                 \
                    volatile unsigned int  addr_v=(unsigned int)addr & HIL_PA_SBZ_MASK;                     \
                    volatile unsigned int  align_size = ((unsigned int)size + ((unsigned int)addr &               \
                                          (HIL_CACHE_LINE_SIZE-1UL)));                                      \
                    volatile unsigned int  addr_end = addr_v + align_size;                                        \
                                                                                                                  \
                    do                                                                                            \
                    {                                                                                             \
                        /* Invalidate cache line by PA. */                                                        \
                        HIL_MEM_WRITE32(HIL_PL130_BASE + HIL_PL130_CLEANINVLINE, addr_v);         \
                                                                                                                  \
                        asm volatile("    DSB");                                                                \
                                                                                                                  \
                        /* Move to the next line. */                                                              \
                        addr_v += HIL_CACHE_LINE_SIZE;                                                      \
                                                                                                                  \
                    } while (addr_v < addr_end);                                                                  \
                }


int _enable_interrupt(struct proc_vring *vring_hw);
void _notify(int cpu_id, struct proc_intr *intr_info);
int _boot_cpu(int cpu_id, unsigned int load_addr);
void _shutdown_cpu(int cpu_id);
void platform_isr(void *data);

#endif /* PLATFORM_H_ */
