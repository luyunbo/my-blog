layout: post
date: 2014/12/17
title: 经典面试题atoi
categories: [learning, OO]
tags: [C++, Java]
---


## 功能简介
atoi是把字符串转换成长整型数的一种函数

<!--more-->

## linux c库函数实现
	/***
	*long atol(char *nptr) - Convert string to long
	*
	*Purpose:
	*       Converts ASCII string pointed to by nptr to binary.
	*       Overflow is not detected.
	*
	*Entry:
	*       nptr = ptr to string to convert
	*
	*Exit:
	*       return long int value of the string
	*
	*Exceptions:
	*       None - overflow is not detected.
	*
	*******************************************************************************/
	
	long __cdecl atol(
	        const char *nptr
	        )
	{
	    int c;              /* current char */
        long total;         /* current total */
        int sign;           /* if '-', then negative, otherwise positive */

        /* skip whitespace */
        while ( isspace((int)(unsigned char)*nptr) )
            ++nptr;

        c = (int)(unsigned char)*nptr++;
        sign = c;           /* save sign indication */
        if (c == '-' || c == '+')
            c = (int)(unsigned char)*nptr++;    /* skip sign */

        total = 0;

        while (isdigit(c)) {
            total = 10 * total + (c - '0');     /* accumulate digit */
            c = (int)(unsigned char)*nptr++;    /* get next char */
        }

        if (sign == '-')
            return -total;
        else
            return total;   /* return result, negated if necessary */
	}
	
	
	/***
	*int atoi(char *nptr) - Convert string to long
	*
	*Purpose:
	*       Converts ASCII string pointed to by nptr to binary.
	*       Overflow is not detected.  Because of this, we can just use
	*       atol().
	*
	*Entry:
	*       nptr = ptr to string to convert
	*
	*Exit:
	*       return int value of the string
	*
	*Exceptions:
	*       None - overflow is not detected.
	*
	*******************************************************************************/
	
	int __cdecl atoi(
	        const char *nptr
	        )
	{
	        return (int)atol(nptr);
	}
面试官至少会期待应聘都能够在不需要提示的情况下，考虑到输入的字符串中有非数字字符和正负号，要考虑到最大的正整数和最小的负整数以及溢出。同时面试试还期待应聘者能够考虑到当输入的字符串不能转换成整数时，应该如何做错误处理。

1、检查字符串是否为空

2、对非法输入，返回0，并设置全局变量

3、溢出

4、空字符串""

5、输入字符串只有"+"或"-"号

	// StringToInt.cpp : Defines the entry point for the console application.
	//
	
	// 《剑指Offer——名企面试官精讲典型编程题》代码
	// 著作权所有者：何海涛
	
	#include "stdafx.h"
	#include <stdio.h>
	#include <stdlib.h>
	
	long long StrToIntCore(const char* str, bool minus);
	
	enum Status {kValid = 0, kInvalid};
	int g_nStatus = kValid;
	
	int StrToInt(const char* str)
	{
		    g_nStatus = kInvalid;
		    long long num = 0;
	
	    if(str != NULL && *str != '\0') 
	    {
	        bool minus = false;
	        if(*str == '+')
	            str ++;
	        else if(*str == '-') 
	        {
	            str ++;
	            minus = true;
	        }
	
	        if(*str != '\0') 
	        {
	            num = StrToIntCore(str, minus);
	        }
	    }
	
	    return (int)num;
	}

	long long StrToIntCore(const char* digit, bool minus)
	{
	    long long num = 0;

	    while(*digit != '\0') 
	    {
	        if(*digit >= '0' && *digit <= '9') 
	        {
	            int flag = minus ? -1 : 1;
	            num = num * 10 + flag * (*digit - '0');
	
	            if((!minus && num > 0x7FFFFFFF) 
	                || (minus && num < (signed int)0x80000000))
	            {
	                num = 0;
	                break;
	            }
	
	            digit++;
	        }
	        else 
	        {
	            num = 0;
	            break;
	        }
	    }
	
	    if(*digit == '\0') 
	    {
	        g_nStatus = kValid;
	    }
	
	    return num;
	}

	// ====================测试代码====================
	void Test(char* string)
	{
	    int result = StrToInt(string);
	    if(result == 0 && g_nStatus == kInvalid)
	        printf("the input %s is invalid.\n", string);
	    else
	        printf("number for %s is: %d.\n", string, result);
	}

	int _tmain(int argc, _TCHAR* argv[])
	{
	    Test(NULL);
	
	    Test("");
	
	    Test("123");
	
	    Test("+123");
	    
	    Test("-123");
	
	    Test("1a33");
	
	    Test("+0");
	
	    Test("-0");
	
	    //有效的最大正整数, 0x7FFFFFFF
	    Test("+2147483647");    
	
	    Test("-2147483647");
	
	    Test("+2147483648");
	
	    //有效的最小负整数, 0x80000000
	    Test("-2147483648");    
	
	    Test("+2147483649");
	
	    Test("-2147483649");
	
	    Test("+");
	
	    Test("-");
	
	    return 0;
	}
