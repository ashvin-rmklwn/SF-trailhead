/**
 * @description       : 
 * @author            : ARM
 * @group             : 
 * @last modified on  : 04-06-2025
 * @last modified by  : ARM
**/
@isTest
public with sharing class MyIterableTest {
    @IsTest
    static void testIterableForLoop() {
        // Step 1: Create a list of strings
        List<String> strings = new List<String>{'Hello', 'World'};

        // Step 2: Create an instance of MyIterable with the list of strings
        MyIterable myIterable = new MyIterable(strings);

        // Step 3: Use a for loop to iterate over the MyIterable instance
        for (String str : myIterable) {
            // Step 4: Print each string using System.debug
            System.debug(str);
        }
    }
}