package br.usp.pcs.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.apache.log4j.Logger;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.RequestScoped;

@RequestScoped
@Component
public class Database {

    private final EntityManager entityManager;
    private static final Logger log = Logger.getLogger(Database.class.getName());
    private static final EntityManagerFactory emfInstance = Persistence
    .createEntityManagerFactory("transactions-optional");

    public Database() {
        log.info("Creating EntityManager...");
        entityManager = emfInstance.createEntityManager();
    }

    public EntityManager getEntityManager() {
        return entityManager;
    }

}
