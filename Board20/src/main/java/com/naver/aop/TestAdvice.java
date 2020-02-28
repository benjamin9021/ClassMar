package com.naver.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class TestAdvice {
	
	
	@Around ("execution( * com.naver.service.TestService*.*(..))")
	public Object around(ProceedingJoinPoint pjp) throws Throwable {
		
		long start = System.currentTimeMillis(); 
		
		Object obj = pjp.proceed();
		
		long end = System.currentTimeMillis();
		System.out.println("#################");
		System.out.println(end-start);
		System.out.println("#################");
		
		return obj;
		
	}
	
	@After("execution( * com.naver.service.TestService*.*(..))")
	public void end(JoinPoint jp) {
		
		System.out.println(":::::::::::::end::::::::::::");
		System.out.println("::::::::::::::::::end:::::::");
		
		System.out.println(jp.getKind());
		System.out.println(jp.getTarget());
		System.out.println(jp.getThis());
		Object[] args = jp.getArgs();
		System.out.println(Arrays.toString(args));
		
		
	}
	
	@Before("execution( * com.naver.service.TestService*.*(..))") 
	public void start() {
		
		System.out.println(":::::::::::::start::::::::::::");
		System.out.println("::::::::::::::::::start:::::::");
		
	}

}
