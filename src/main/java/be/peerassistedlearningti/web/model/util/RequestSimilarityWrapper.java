package be.peerassistedlearningti.web.model.util;

import be.peerassistedlearningti.model.Request;


public class RequestSimilarityWrapper implements Comparable<RequestSimilarityWrapper> {
    float similarity;
    Request request;

    public RequestSimilarityWrapper(float similarity, Request request) {
        this.similarity = similarity;
        this.request = request;
    }

    public float getSimilarity() {
        return similarity;
    }

    public void setSimilarity(float similarity) {
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
        return Float.compare(similarity, o.similarity);
    }
}
