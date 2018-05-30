#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <fcntl.h>
#include <unistd.h> 
#include <sys/mman.h>
#define RTC_REG_BASE (0x43C20000)
#define MAP_SIZE 4096UL
#define MAP_MASK (MAP_SIZE - 1)

static int dev_fd;

unsigned int rtc_reg0,rtc_reg1;
unsigned char second_old=0;
int i;
int main(int argc, char **argv)
{
	unsigned char time_v[6];
	unsigned char time_temp[6];
	dev_fd = open("/dev/mem", O_RDWR | O_SYNC);      

	if (dev_fd < 0)  
	{
		printf("open(/dev/mem) failed.");    
		return 0;
	}  

	void *map_base=(unsigned char * )mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, dev_fd, RTC_REG_BASE);
	*(volatile unsigned long *)(map_base + 12) = 0x00160A0A; //修改该寄存器地址的value
	*(volatile unsigned long *)(map_base + 8) = 0x000C0000; //修改该寄存器地址的value
	*(volatile unsigned long *)(map_base + 12) = 0x80160A0A; //修改该寄存器地址的value
	usleep(100000);
	*(volatile unsigned long *)(map_base + 12) = 0x00160A0A; //修改该寄存器地址的value
	usleep(100000);
	while(1)
	{
		rtc_reg1 = *(volatile unsigned int *)(map_base + 4);
		rtc_reg0 = *(volatile unsigned int *)(map_base + 0);
		second_old=time_v[0];
		time_temp[5] = (unsigned char)(rtc_reg1 >> 16);        //RTC year
		time_temp[4] = (unsigned char)(rtc_reg1 >> 8);         //RTC month
		time_temp[3] = (unsigned char)(rtc_reg1);              //RTC date


		time_temp[2] = (unsigned char)(rtc_reg0 >> 16);        //RTC Hour
		time_temp[1] = (unsigned char)(rtc_reg0 >> 8);         //RTC Munite
		time_temp[0] = (unsigned char)(rtc_reg0);              //RTC Second

		for (i=0;i<6;i++){

			time_v[i] = time_temp[i]/16*10+time_temp[i]%16;//格式为: 秒 分 时 日 月 星期 年
		}



		if (second_old!=time_v[0]){

			printf("current time is:20%d-%d-%d %d:%d:%d\n",time_v[5],time_v[4],time_v[3],time_v[2],time_v[1],time_v[0]);  //convert string

		}

	}
	if(dev_fd)
		close(dev_fd);

	munmap(map_base,MAP_SIZE);//解除映射关系

	return 0;
}
