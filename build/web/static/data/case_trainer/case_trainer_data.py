import lxml.etree as ET
import urllib2
import datetime
import re
import os
from collections import Counter
import json


#===============================================================================
# pth="slov_wiki/collect_urls"
# fls=os.listdir(pth)
# 
# def get_links(pth):
#     data=list()
#     root=ET.parse(pth)
#     div_tab=root.xpath("//div[@class='mw-content-ltr']")[0]
#     for a in div_tab.iter("a"):
#         data.append((a.attrib))
#     return data
# 
# links=[]
# for fl in fls[6:]:
#     links.extend(get_links(pth+"/"+fl))
# 
# 
# sites=[]
# def get_site(attrs):
#     link=attrs["href"]
#     pref="http://en.wiktionary.org"
#     try:
#         resp=urllib2.urlopen(pref+link)
#         html = resp.read()
#         return html
#     except:
#         print attrs
# 
# for i,link in enumerate(links):
#     print link
#     site=get_site(link)
#     if site and "title" in link:
#         link["title"]=link["title"].replace(u'\u010d',"ch").replace(u'\u0161',"sh").replace(u'\u017e',"zh")
#         try:
#             name="slov_wiki/sing_sites/{}.html".format(link["title"])
#         except:
#             foo=datetime.datetime.now()
#             name="slov_wiki/sing_sites/{0}{1}.html".format(foo.second,foo.microsecond)
#         with open(name,"w+") as f:
#             f.write(site)
# 
FLEXDB={
    "(masculine inan., hard)":[["","","a","u","u","om"],["a","a","ov","oma","ih","oma"],["i","e","ov","om","ih","i"]],
    "(masculine anim., hard)":[["","a","a","u","u","om"],["a","a","ov","oma","ih","oma"],["i","e","ov","om","ih","i"]],
    "(masculine inan., soft)":[["","","a","u","u","em"],["a","a","ev","ema","ih","ema"],["i","e","ev","em","ih","i"]],
    "(masculine anim., soft)":[["","a","a","u","u","em"],["a","a","ev","ema","ih","ema"],["i","e","ev","em","ih","i"]],
    "(masculine inanimate, plural in -ov-)":[["","","a","u","u","om"],["ova","ova","ov","ovoma","ovih","ovoma"],["ovi","ove","ov","ovom","ovih","ovi"]],
    "(masculine animate, plural in -ov-)":[["","a","a","u","u","om"],["ova","ova","ov","ovoma","ovih","ovoma"],["ovi","ove","ov","ovom","ovih","ovi"]],
    "(feminine, a-stem)":[["a","o","e","i","i","o"],["i","i","","ama","ah","ama"],["e","e","","am","ah","ami"]],
    "(feminine, i-stem)":[["","","i","i","i","jo"],["i","i","i","ma","ih","ma"],["i","i","i","im","ih","mi"]],
    "(neuter, hard)":[["o","o","a","u","u","om"],["i","i","","oma","ih","oma"],["a","a","","om","ih","i"]],
    "(neuter, soft)":[["e","e","a","u","u","em"],["i","i","","ema","ih","ema"],["a","a","","em","ih","i"]],
    "(neuter, n-stem)":[["e","e","ena","enu","enu","enom"],["eni","eni","en","enoma","enih","enoma"],["ena","ena","en","enom","enih","eni"]],
    "(neuter, s-stem)":[["o","o","esa","esu","esu","esom"],["esi","esi","es","esoma","esih","esoma"],["esa","esa","es","esom","esih","esi"]],
    "(neuter, t-stem)":[["e","e","eta","etu","etu","etom"],["eti","eti","et","etoma","etih","etoma"],["eta","eta","et","etom","etih","eti"]]
    }
 
def get_tables(pth):
    #print pth
    wik_word=ET.parse(pth)
    root=wik_word.getroot()
    nframes = root.xpath("//div[@class='NavFrame']")
    for nframe in nframes:
        lang=nframe.xpath(".//span[@lang='sl']")
        infl_tab=nframe.xpath(".//table[@class='inflection-table']")
        if lang and infl_tab:
            tab = infl_tab[0]
            data = [[],[],[],[]]
            rows=tab.findall("tr")
            for row in rows:
                for i,td in enumerate(row):
                    data[i].append(" ".join(list(td.itertext())))
            header=nframe.xpath(".//div[@class='NavHead']")[0]
            data.append(" ".join(header.itertext()))
            return data

pth="/home/igor/Documents/eclipse_data/case_trainer/slov_wiki/sing_sites"
#pth="slov_wiki/test"
fls=os.listdir(pth)
tabs=list()
for fl in fls:
    tab=get_tables(pth+"/"+fl)
    if tab:
        tabs.append(tab)
tabs

desc_set=list()
for tab in tabs:
    info=re.findall(r"\(.+?\)",tab[-1])[0]
    desc_set.append(info)
 
freq_dist=Counter(desc_set)

import sys
import goslate
gs = goslate.Goslate()

sys.getdefaultencoding()
reload(sys)  # Reload does the trick!
sys.setdefaultencoding('utf8')

def get_desc_info(tab):
    info=re.search(r"\(.+?\)",tab[-1]).group(0)
    print(info)
    #assert len(info)==1
    if info and  info in FLEXDB: #get rid of irrelugars (at first...)
        num_map={"singular":0,"dual":1,"plural":2}
        print(tab)
        tab_dct={(t[0],num_map[t[0]]):t[1:] for t in tab[1:-1] if t}
        paradigm=FLEXDB[info]
        dif_forms=False
        correct=True
        stems=[[],[],[]] #stems for the three numerus (just in case of variable stem else just one form in list)
        for par,i in tab_dct.keys():
            par_word=tab_dct[(par,i)]
            par_ideal=paradigm[i]
            refer_len=len(par_ideal[0])
            refer=par_word[0][:-refer_len] if refer_len else par_word[0] #get the stem for comparing to other forms
            for ii,p in enumerate(par_ideal):
                len_fl=len(p)
                if len_fl: #cut flexion if there is one else leave word
                    word_fl=par_word[ii][-len_fl:]
                    stem=par_word[ii][:-len_fl]
                else:
                    word_fl=""
                    stem=par_word[ii]
                stems[i].append(stem) #insert the stem to the right numerus
                if stem!=refer and not dif_forms: #stem isnt the same as the reference stem, means stem alternation
                    dif_forms=True
                if word_fl!=p: #word flexion isnt equal to the ideal flexion, so leave fn
                    print("False case: %s != %s of %s" %(word_fl,p, stem.title()))
                    correct=False
                    return None 
        assert correct
        returnStem=stems if dif_forms else [stem]
        numerus=[i for v,i in tab_dct.keys()]
        nomForm=tab[1][1].encode("utf8")
        par_obj={"classification":info,
                 "nominativeStem": stem,
                 "stem":returnStem,
                 "numerus":numerus,
                 "hasStemAlt": len(returnStem)>1,
                 "nomForm":nomForm,
                 "genus": re.search("\w+", info[1:]).group(0),
                 "meaningDe": gs.translate(nomForm, 'de',"sl"),
                 "meaningEn": gs.translate(nomForm, 'en',"sl")
                 }
        return par_obj


descDb={
        "words":filter(None,map(get_desc_info,tabs)),
        "flexions":FLEXDB
        }                

with open("../descApp.json","w+") as f:
    f.write(json.dumps(descDb,indent=1))

