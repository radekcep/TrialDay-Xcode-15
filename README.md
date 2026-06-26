# TrialDay

Find attached an Xcode project which is a starting point for an app displaying transactions.
It contains a mocked API (TransactionsAPI.swift) which returns asynchronously a list of transactions or an error.

Please create an app which implements the following user stories:

- As a user I want to see a tour/splash screen at the first start of the app (just use a blank screen with a close button).
- As a user I want to see a list of transactions.
- As a user I want to be informed if loading of transactions is in progress or failed.
- As a user I want to retry loading of transactions when initial loading failed.
- As a user I want to see the title, subtitle, additionalTexts.lineItems and amount of the transaction in the list of transactions.
- As a user I want to select a transaction and see more details (just display the title and subtitle).
- As a user I want to see the sum of all transactions above the list of transactions.

Choose an approach and app architecture you think of as most suitable for building an app which has to be maintained over a long time by a large team and which will get constantly extended. 
Make sure to add proper and sufficient unit testing.

Feel free to change anything in the current setup/code of the project.
