#Example to get you going:
# code for annotating the text in a URL

import requests  # http://docs.python-requests.org/en/latest/
import json
from bs4 import BeautifulSoup
import spotlight

# Get HTML code from url
url ='http://www.bbc.com/news/world-us-canada-33753067'
bbc = requests.get(url)
soup = BeautifulSoup(bbc.text,"lxml")

# Make text file
text = ""
for article in soup.findAll('p'):
    text += article.text + " "
# print text

# Get user input
print "Enter the confidence: ",
conf = raw_input()
print "Enter the support: ",
sup = raw_input()

# Make annotations with dbpedia spotlight
annotations = spotlight.annotate('http://spotlight.sztaki.hu:2222/rest/annotate',
    text, confidence = conf, support = sup)

print annotations



# Open file for text
# output = open('output.txt','w')

# # Get every piece of text between the paragraph tags and write them in a file
# for article in soup.findAll('p'):
#     article_text = article.text
#     output.write(article_text + '\n')

# Close the file
# output.close()
