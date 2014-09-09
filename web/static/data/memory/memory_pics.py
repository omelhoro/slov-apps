import urllib
import mechanize
url='http://cdn.morguefile.com/imageData/public/files/a/agulek1222/01/l/1358285661va4ba.jpg'
browser = mechanize.Browser()
image_response = browser.open_novisit(url)
with open('image_out.png', 'wb') as f:
        f.write(image_response.read())
        
#url='http://mrg.bz/hxVY5v'
#url = 'http://www.goldb.org/images/goldb.png'
f = urllib.urlopen(url)    
fh = open('pullover.jpg', 'wb')
fh.write(f.read())
fh.close()




