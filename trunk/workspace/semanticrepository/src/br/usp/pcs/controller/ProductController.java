package br.usp.pcs.controller;

import static br.com.caelum.vraptor.view.Results.logic;

import java.util.List;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;
import br.com.caelum.vraptor.validator.ValidationMessage;
import br.usp.pcs.dao.ProductRepository;
import br.usp.pcs.model.Product;

@Resource
public class ProductController {

    private final Result result;

    private final Validator validator;

    private final ProductRepository repository;

    public ProductController(Result result, ProductRepository repository, Validator validator) {
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
    public void add(Product product) {
        validator.onError().goTo(ProductController.class).form();
        if ("".equals(product.getName())) {
            validator.add(new ValidationMessage("should_not_be_empty", "name"));
        }
        validator.validate();
        repository.persist(product);
        result.include("message", "Added sucessfully!");
        result.use(logic()).redirectTo(ProductController.class).list();

    }

    @Get
    @Path("/products")
    public List<Product> list() {
        return repository.listAll();
    }

    @Get
    @Path("/products/{product.id}")
    public void view(Product product) {
        result.include("product", repository.find(product.getId()));
    }

    @Delete
    @Path("/products/{product.id}")
    public void delete(Product product) {
        repository.remove(product);
        result.use(logic()).redirectTo(ProductController.class).list();
    }

}
