package br.usp.pcs.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.RequestScoped;
import br.usp.pcs.model.Product;

@Component
@RequestScoped
public class ProductRepository {



    private final EntityManager em;

    public ProductRepository(EMF emf) {
        this.em = emf.getEntityManager();
    }

    public Product find(Long id) {
        return em.find(Product.class, id);
    }

    public Product getReference(Long id) {
        return em.getReference(Product.class, id);
    }

    public Product merge(Product p) {
        return em.merge(p);
    }


    public void persist(Product p) {
        em.persist(p);
    }

    public void remove(Product p) {
        em.remove(p);
    }

    public List<Product> listAll() {
        String s = String.format("SELECT p FROM %s p", Product.class.getName());
        Query query = em.createQuery(s);
        List<Product> list = query.getResultList();
        return list;
    }
}
