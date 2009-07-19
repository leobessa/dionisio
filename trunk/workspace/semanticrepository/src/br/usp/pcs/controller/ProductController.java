package br.usp.pcs.controller;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.com.caelum.vraptor.view.Results;
import br.usp.pcs.dao.ProductRepository;
import br.usp.pcs.model.Product;

@Resource
public class ProductController {

    private final Result result;

    private final Validator validator;

    private final ProductRepository repository;

    public ProductController(Result result, ProductRepository repository,
            Validator validator) {
        this.result = result;
        this.repository = repository;
        this.validator = validator;
    }

    @Get
    @Path("/products/new")
    public void form() {
    }

    @Post
    @Path("/products")
    public void create(Product product) {
        validate(product);

        repository.persist(product);
        result.include("message", "Added sucessfully!");
        result.use(Results.logic()).redirectTo(ProductController.class).index();
    }

    private void validate(Product product) {
        validator.onError().goTo(ProductController.class).form();
        if ("".equals(product.getName())) {
            validator.add(new ValidationMessage("should_not_be_empty", "name"));
        }
        try {
            new URL(product.getUrl());
        } catch (MalformedURLException e) {
            validator.add(new ValidationMessage("should_be_valid_url", "url"));
        }
        validator.validate();
    }

    @Get
    @Path("/products")
    public List<Product> index() {
        return repository.listAll();
    }

    @Get
    @Path("/products/store:{string.value}")
    public List<Product> index(String store) {
        return repository.listAll();
    }

    @Get
    @Path("/products/{product.id}")
    public void show(Product product) {
        result.include("product", repository.find(product.getId()));
    }

    @Delete
    @Path("/products/{product.id}")
    public void destroy(Product product) {
        Product managedProduct = repository.getReference(product.getId());
        repository.remove(managedProduct);
        result.use(Results.logic()).redirectTo(ProductController.class).index();
    }

    @Get
    @Path("/products/edit/{product.id}")
    public void edit(Product product) {
        show(product);
    }

    @Put
    @Path("/products/{product.id}")
    public void update(Product product) {
        validate(product);
        Product managedProduct = repository.find(product.getId());
        managedProduct.setBrand(product.getBrand());
        managedProduct.setCategory(product.getCategory());
        managedProduct.setDescription(product.getDescription());
        managedProduct.setName(product.getName());
        managedProduct.setPhoto(product.getPhoto());
        managedProduct.setPrice(product.getPrice());
        managedProduct.setUrl(product.getUrl());
        managedProduct.setStoreName(product.getStoreName());
        repository.merge(managedProduct);
        result.include("message", "Updated sucessfully!");
        result.use(Results.logic()).redirectTo(ProductController.class).show(managedProduct);
    }

}