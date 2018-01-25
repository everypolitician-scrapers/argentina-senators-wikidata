#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

names = EveryPolitician::Wikidata.wikipedia_xpath(
  url: 'https://es.wikipedia.org/wiki/Anexo:Senadores_nacionales_de_Argentina',
  after: '//span[@id="Lista_de_senadores"]',
  before: '//span[@id="Véase_también"]',
  xpath: './/table//tr//td[2]//a[not(@class="new")]/@title'
)

sparq = <<EOQ
  SELECT ?item ?start ?end WHERE {
    ?item p:P39 ?posn .
    ?posn ps:P39 wd:Q18711738 ; pq:P580 ?start .
    OPTIONAL { ?posn pq:P582 ?end }
    FILTER (?start >= "2011-01-01T00:00:00Z"^^xsd:dateTime || ?end >= "2011-01-01T00:00:00Z"^^xsd:dateTime) .
  }
EOQ
ids = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { es: names })
