/**
 * @description       : 
 * @author            : ARM
 * @group             : 
 * @last modified on  : 04-06-2025
 * @last modified by  : ARM
**/
public with sharing class MyIterable implements Iterable<String> {
    private List<String> strings;

    // Constructor to initialize the strings list
    public MyIterable(List<String> strings) {
        this.strings = strings;
    }

    // Iterator method to return an iterator for the strings list
    public Iterator<String> iterator() {
        return strings.iterator();
    }
}