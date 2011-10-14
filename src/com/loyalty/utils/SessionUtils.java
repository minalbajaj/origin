package com.loyalty.utils;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class SessionUtils {
	
	public static SessionFactory sessionFactory ;
	/**
	 * This will return sessionfactory object
	 * @return
	 */
	public static SessionFactory getSessionFactory(){
		if(sessionFactory == null){
			Configuration cfg = new Configuration();
			sessionFactory = cfg.configure().buildSessionFactory();
		}
		return sessionFactory;
	}
	

}
