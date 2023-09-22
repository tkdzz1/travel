package com.himedia.springboot;

public interface EmailService {
	String sendSimpleMessage(String to)throws Exception;
}
