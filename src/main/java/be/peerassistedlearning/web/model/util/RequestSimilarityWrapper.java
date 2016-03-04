package be.peerassistedlearning.web.model.util;

import be.peerassistedlearning.model.Request;


public class RequestSimilarityWrapper implements Comparable<RequestSimilarityWrapper> {
    double similarity;
    Request request;

    public RequestSimilarityWrapper(double similarity, Request request) {
        this.similarity = similarity;
        this.request = request;
    }

    public double getSimilarity() {
        return similarity;
    }

    public void setSimilarity(double similarity) {
        this.similarity = similarity;
    }

    public Request getRequest() {
        return request;
    }

    public void setRequest(Request request) {
        this.request = request;
    }


    @Override
    public int compareTo(RequestSimilarityWrapper o) {
        return Double.compare(similarity, o.similarity);
    }
}
