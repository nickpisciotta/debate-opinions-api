Created a small web scraping service with Sinatra. 
I have implemented a pretty simple error handling strategy for a few of the possible exceptions that could be thrown. OpenURI will throw an OpenURI::HTTPError if the site is not found or a Errno::ENOENT (system call error) if the url does not contain a protocol identifier--a 404 or 400 is returned, respectively. A more comprehensive approach could be used to accomodate more errors as the API is built out.  A 204 is returned if no urls are provided.
Multiple URLs from debate.org opinions can be sent in the body to be scraped and returned.
I chose to use a POST HTTP method and pass the urls in the body since multiple urls could become unwieldy as query params. The API will provide the title, percent yes and no, all opinions with respective authors, total number of opinions, and all related topics for a debate topic. 

#### To run the application 
```
$ rackup config.ru
```
#### To run the controller tests
```
$ rspec spec 
```
#### Endpoint  
```
POST "/opinions" body: {"urls": ["http://www.debate.org/opinions/should-drug-users-be-put-in-prison"]}
```
#### Example Repsonse
```
[
  {
    "title": "Should drug users be put in prison?",
    "percentage_yes": "50%",
    "percentage_no": "50%",
    "opinions": [
      {
        "comment": "Yes, after intervention has failed Specifically speaking about hard drugs:They're a threat to public safety and private property when they're hopped up on their cocaine and heroin. Their \"need\" to chase highs also impedes their ability to earn a living, and since the drugs that they consume take a massive toll on their health they wind up having major issues when they're old. The health bills for that are then paid by the taxpayer since they tend to go to the ER, since they know that they can't pay. Also, people who distributing hard drugs and selling prescription medications should be given the Duterte treatment.",
        "author": "Adalman"
      }],
    "total_opinions": 8,
    "related_topics": [
      "Powerful Dua To Get Married Soon",
      "Are Hispanics, Latin Americans and/or Brown people becoming scapegoats and susceptible to hate crime?",
    ]
  }
]
```
