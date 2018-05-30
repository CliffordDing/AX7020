/*
 * DS1302 Real Time Clock Driver
 *
 * Copyright (C) 2017 ALINX Inc.
 *
 * This program is free software
 *
 *
 */

#include <linux/init.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/platform_device.h>
#include <linux/io.h>
#include <linux/delay.h>
#include <linux/rtc.h>

#define RTC_SET_DATE      0x0c
#define RTC_SET_TIME      0x08

#define RTC_GET_DATE      0x04
#define RTC_GET_TIME      0x00

struct ax_rtc_ds1302_dev {
	struct rtc_device	*rtc;
	void __iomem		*reg_base;
	int					alarm_irq;
	int					sec_irq;
	int                 calibval;
};


static int ax_rtc_ds1302_set_time(struct device *dev, struct rtc_time *tm)
{

	struct ax_rtc_ds1302_dev *xrtcdev = dev_get_drvdata(dev);
	u32 utime, udate;

	u32 tempY  = ((tm->tm_year)/10*16+(tm->tm_year)%10)<<16;
	u32 tempM = (tm->tm_mon/10*16+tm->tm_mon%10)<<8;
	u32 tempD = (tm->tm_mday/10*16+tm->tm_mday%10);

	udate = tempY + tempM + tempD + 0x80000000;

	u32 tempH = (tm->tm_hour/10*16+ tm->tm_hour%10)<<16;
	u32 tempI = (tm->tm_min/10*16+tm->tm_min%10)<<8;
	u32 tempS = tm->tm_sec;

	utime = tempH + tempI + tempS; 

	writel(udate, xrtcdev->reg_base + RTC_SET_DATE);
	writel(utime, xrtcdev->reg_base + RTC_SET_TIME);

	return 1;
}


static int ax_rtc_ds1302_read_time(struct device *dev, struct rtc_time *tm)
{
	struct ax_rtc_ds1302_dev *xrtcdev = dev_get_drvdata(dev);


	u32 utime = readl(xrtcdev->reg_base + RTC_GET_TIME); 
	u32 udate = readl(xrtcdev->reg_base + RTC_GET_DATE);

	u8 temp = (unsigned char)(udate >> 16);
	tm->tm_year = temp/16*10 + temp%16 ;

	temp = (unsigned char)(udate >> 8);
	tm->tm_mon  = temp/16*10 + temp%16;


	temp = (unsigned char)(udate);	
	tm->tm_mday = temp/16*10 + temp%16;; 

	temp = (unsigned char)(utime >> 16);
	tm->tm_hour = temp/16*10 + temp%16;


	temp = (unsigned char)(utime >> 8); 
	tm->tm_min	= temp/16*10 + temp%16;


	temp = (unsigned char)(utime);		
	tm->tm_sec= temp/16*10 + temp%16;

	if(rtc_valid_tm(tm)<0)
	{
		tm->tm_year 	= 117;
		tm->tm_mon  	= 11;
		tm->tm_mday 	= 10;
		tm->tm_hour 	= 13;
		tm->tm_min  	= 0;
		tm->tm_sec		= 0;
		ax_rtc_ds1302_set_time(dev,tm);
	}	

	return rtc_valid_tm(tm);
}


static const struct rtc_class_ops ax_rtc_ops = {
	.set_time 			= ax_rtc_ds1302_set_time,
	.read_time			= ax_rtc_ds1302_read_time,
};


static int ax_rtc_ds1302_probe(struct platform_device *pdev)
{
	struct ax_rtc_ds1302_dev 	*xrtcdev;
	struct resource 	*res;
	int 				ret;


	xrtcdev = devm_kzalloc(&pdev->dev, sizeof(*xrtcdev), GFP_KERNEL);
	if(!xrtcdev)
		return -ENOMEM;

	platform_set_drvdata(pdev, xrtcdev);

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if(res == NULL)
	{
		return -ENOENT;
	}

	xrtcdev->reg_base = devm_ioremap_resource(&pdev->dev,res);
	if(IS_ERR(xrtcdev->reg_base))
	{

		return PTR_ERR(xrtcdev->reg_base);
	}


	device_init_wakeup(&pdev->dev, 1);

	xrtcdev->rtc = devm_rtc_device_register(&pdev->dev, pdev->name, 
			&ax_rtc_ops, THIS_MODULE);

	return PTR_ERR_OR_ZERO(xrtcdev->rtc);

	
}



static int ax_rtc_ds1302_remove(struct platform_device *pdev)
{
	device_init_wakeup(&pdev->dev, 0);
	return 0;
}

static int __maybe_unused ax_rtc_ds1302_suspend(struct device *dev)
{
	struct platform_device *pdev 	= to_platform_device(dev);
	struct ax_rtc_ds1302_dev *xrtcdev 	= platform_get_drvdata(pdev);


	return 0;
}

static int __maybe_unused ax_rtc_ds1302_resume(struct device *dev)
{
	struct platform_device *pdev 	= to_platform_device(dev);
	struct ax_rtc_ds1302_dev *xrtcdev 	= platform_get_drvdata(pdev);


	return 0;
}


static SIMPLE_DEV_PM_OPS(ax_rtc_ds1302_pm_ops, ax_rtc_ds1302_suspend, ax_rtc_ds1302_resume);

static const struct of_device_id ax_rtc_ds1302_of_match[] = {
	{.compatible = "alinx,ax-rtc-ds1302" },
	{ }
};
MODULE_DEVICE_TABLE(of, ax_rtc_ds1302_of_match);

static struct platform_driver ax_rtc_ds1302_driver = {
	.probe		= ax_rtc_ds1302_probe,
	.remove		= ax_rtc_ds1302_remove,
	.driver		= {
		.name	= KBUILD_MODNAME,
		.pm		= &ax_rtc_ds1302_pm_ops,
		.of_match_table	= ax_rtc_ds1302_of_match,
	},
};

module_platform_driver(ax_rtc_ds1302_driver);

MODULE_DESCRIPTION("Alinx DS1302 RTC driver");
MODULE_AUTHOR("Guowc.");
MODULE_LICENSE("GPL v2");

