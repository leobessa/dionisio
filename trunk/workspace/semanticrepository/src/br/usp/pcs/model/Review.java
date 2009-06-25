package br.usp.pcs.model;

import java.util.Calendar;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Review {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * The item being reviewed
     */
    private Product itemReviewed;

    /**
     * A numerical quality rating for the item (for example, 4) based on a scale
     * of 1-5. You can optionally specify worst (default: 1) or best (default:
     * 5)
     */
    private Integer rating;

    /**
     * The author of the review.
     */
    private Person reviewer;

    /**
     * The date that the item was reviewed.
     */
    private Calendar dtreviewed;

    /**
     * The body of the review.
     */
    private String description;

    /**
     * A short summary of the review.
     */
    private String summary;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Product getItemReviewed() {
        return itemReviewed;
    }

    public void setItemReviewed(Product itemReviewed) {
        this.itemReviewed = itemReviewed;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public Person getReviewer() {
        return reviewer;
    }

    public void setReviewer(Person reviewer) {
        this.reviewer = reviewer;
    }

    public Calendar getDtreviewed() {
        return dtreviewed;
    }

    public void setDtreviewed(Calendar dtreviewed) {
        this.dtreviewed = dtreviewed;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

}
