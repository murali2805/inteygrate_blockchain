trigger unzipCallout on ZipFile__c (after update) {
    CalloutHandler.UnzipCallout();
}