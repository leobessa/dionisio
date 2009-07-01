package br.usp.pcs.provider;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import ognl.OgnlRuntime;

public class GoogleAppEngineContextListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent arg0) {
        OgnlRuntime.setSecurityManager(null);
    }

    public void contextDestroyed(ServletContextEvent arg0) {

    }


}
