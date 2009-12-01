#!/usr/bin/env python
#-*- coding: ISO-8859-1 -*-

import jinja2
import sqlite3
from numpy import *
from tempfile import NamedTemporaryFile

class StdDev:
    def __init__(self):
        self.values = []

    def step(self, value):
        self.values.append(value)

    def finalize(self):
        return array(self.values).std()

def inverte(d):
    d_ = {}
    for d, values in d.items():
        for v in values:
            d_.setdefault(v, [])
            d_[v].append(d)
    return d_

def run(cmd):
    import subprocess
    return subprocess.Popen(cmd,stdout=subprocess.PIPE).communicate()[0]

def call_script(input, output):
    out = run(['./bargraph.pl', '-gnuplot', '-pdf', input])
    file(output,'w+').write(out)

def gen_bar(x_labels, graph, out_name, yformat='%g', title='', xlabel='', ylabel='', sort=False, sort_col=0, rotate=False):
    
    conf = NamedTemporaryFile()
    conf.write('=cluster;%s\n' % ';'.join(x_labels))
    conf.write('=table\n')
    conf.write('yformat=%s\n' % yformat)
    if title:
        conf.write('title=%s\n' % title)
    if xlabel:
        conf.write('xlabel=%s\n' % xlabel)
    if ylabel:
        conf.write('ylabel=%s\n' % ylabel)
    if not rotate:
        conf.write('=norotate\n')
    graph_items = graph.items()
    if sort:
        graph_items.sort(cmp=lambda a,b: cmp(a[1][sort_col], b[1][sort_col]))
    for x, y_list in graph_items:
        columns = ' '.join(map(str, y_list))
        conf.write('%s %s\n' % (x, columns))
    conf.flush()
    call_script(conf.name, out_name)
    #raw_input('')
    conf.close()

def gen_erro(c):
    graph = {}
    c.execute("select avg(abs(r.stars-sr.predicted_rating)) as erro, stddev(abs(r.stars-sr.predicted_rating)), sr.algorithm from ratings r, system_recommendations sr where r.product_id = sr.product_id and r.user_id = sr.user_id group by sr.algorithm union all select avg(abs(5-r.stars)), stddev(abs(5-r.stars)), 'direto' from ratings r, user_recommendations ur, users u where r.product_id = ur.product_id and r.user_id = ur.target_id and u.id = r.user_id")
    for erro_medio, erro_desvio, algoritmo in c.fetchall():
        graph[algoritmo] = [erro_medio, erro_desvio]
    print graph
    gen_bar(['Erro Medio', 'Desvio do Erro'], graph, 'grafico_erro.pdf')

def gen_notas(c):
    graph = {}
    c.execute("select cast(round(r.stars,0) as INTEGER) as erro, count(*)*100/(select count(*) from system_recommendations _sr, users _u where _sr.algorithm = sr.algorithm and _u.id = _sr.user_id and _u.stage_number >=6), sr.algorithm from ratings r, system_recommendations sr, users u where r.product_id = sr.product_id and r.user_id = sr.user_id and u.id = sr.user_id and u.stage_number >=6 group by erro, sr.algorithm union all select cast(round(r.stars,0) as INTEGER) as erro, count(*)*100/(select count(*) from user_recommendations _ur, users _u where _u.id = _ur.target_id and _u.stage_number >=6), 'direta' from ratings r, user_recommendations ur, users u where r.product_id = ur.product_id and r.user_id = ur.target_id and u.id = r.user_id and u.stage_number >=6 group by erro")
    for faixa, p, algoritmo in c.fetchall():
        agrupa = {1:0, 2:0, 3: 1, 4: 2, 5: 2}
        graph.setdefault(algoritmo, [0,0,0])
        graph[algoritmo][agrupa[faixa]] += p
    print graph
    gen_bar(['1-2', '3', '4-5'], graph, 'grafico_notas.pdf',
        yformat='%g%%', sort=True, sort_col=0)
    graph = inverte(graph)
    print graph
    gen_bar(['a','b','c','d'], graph, 'grafico_notas_inv.pdf',
        yformat='%g%%')


def main():
    con = sqlite3.connect('../prototipo/experimento/db/production.sqlite3')
    con.create_aggregate("stddev", 1, StdDev)
    c = con.cursor()
    gen_erro(c)
    gen_notas(c)

main()
