package br.usp.pcs.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import com.google.appengine.api.datastore.Text;

@Entity
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * The brand of the product—for example, ACME.
     */
    private String brand;
    /**
     * The product category—for example, "Books—Fiction", "Heavy Objects", or
     * "Cars".
     */
    private String category;
    /**
     * Product description
     */
    private Text description;
    /**
     * Product name
     */
    private String name;
    /**
     * Floating point number. Can use currency format.
     */
    private Double price;
    /**
     * URL of product photo
     */
    private String photo;
    /**
     * URL of product page
     */
    private String url;

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description == null ? "" : description.getValue();
    }

    public void setDescription(String description) {
        this.description = new Text(description);
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

}
