#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath( 
  url: 'https://es.wikipedia.org/wiki/Anexo:Senadores_nacionales_de_Argentina',
  after: '//span[@id="Senadores"]',
  before: '//span[@id="V.C3.A9ase_tambi.C3.A9n"]',
  xpath: './/table//tr//td[1]//a[not(@class="new")]/@title',
) 

EveryPolitician::Wikidata.scrape_wikidata(names: { es: names })

