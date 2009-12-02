#!/usr/bin/env python
#-*- coding: ISO-8859-1 -*-


import sqlite3
from scipy.stats import *
from numpy import *

def print_per_line(f, l, n=10):
    for i, c in enumerate(l):
        f.write('%s' % c)
        if (i+1) % n == 0:
            f.write('\n')
        else:
            f.write('\t')

def tests(s1, s2):
    print 'student:', ttest_ind(s1, s2)[1]
    print 'mann whitney:', mannwhitneyu(s1, s2)[1]*2
    print 'wilcoxon ranksum:', ranksums(s1, s2)[1]
    n = min(len(s1), len(s2))
    print 'wilcoxon:', wilcoxon(s1[:n], s2[:n])[1]
    print 'kruskal:', kruskal(array(s1), array(s2))[1]

def main():
    con = sqlite3.connect('../prototipo/experimento/db/production.sqlite3')
    c = con.cursor()
    c.execute('select r.stars from ratings r, users u where u.id = r.user_id and u.stage_number >=6')
    #print [ v[0] for v in c.fetchall()]
    print normaltest([ v[0] for v in c.fetchall()])

    c.execute('select r.stars from ratings r, user_recommendations ur, users u where r.product_id = ur.product_id and r.user_id = ur.target_id and u.id = r.user_id and ur.sender_id in (select distinct _u.id from users _u where _u.group_id = u.group_id and _u.id <> u.id)')
    amigos = [ v[0] for v in c.fetchall() ]
    print_per_line(file('amigos.txt', 'w+'), amigos)
    
    #print shapiro(amigos)
    
    c.execute('select r.stars from ratings r, user_recommendations ur, users u where r.product_id = ur.product_id and r.user_id = ur.target_id and u.id = r.user_id and ur.sender_id in (select distinct _u.id from users _u where _u.group_id <> u.group_id and _u.id <> u.id)')
    nao_amigos = [ v[0] for v in c.fetchall() ]
    print_per_line(file('desconhecidos.txt', 'w+'), nao_amigos)
    c.execute('select r.stars from ratings r, user_recommendations ur, users u where r.product_id = ur.product_id and r.user_id = ur.target_id and u.id = r.user_id')

    diretas = [ v[0] for v in c.fetchall() ]
    print_per_line(file('diretas.txt', 'w+'), diretas)
    c.execute('select r.stars, sr.algorithm from ratings r, system_recommendations sr where r.product_id = sr.product_id and r.user_id = sr.user_id')

    graph = {}
    for rating, algoritmo in c.fetchall():
        graph.setdefault(algoritmo, [])
        graph[algoritmo].append(rating)
    for algoritmo, values in graph.items():
        print_per_line(file('%s.txt' % algoritmo, 'w+'), values)
    print '\nAmigos x desconhecidos:'
    tests(amigos, nao_amigos)
    
    print '\nConfianca x direta:'
    tests(graph['trust'], diretas)
    
    print '\nConfianca x desconhecidos:'
    tests(graph['trust'], nao_amigos)
    
    print '\nConfianca x profile:'
    tests(graph['trust'], graph['profile'])
    
    print '\nConfianca x item:'
    tests(graph['trust'], graph['item'])
    
main()
