#!/usr/bin/env python
#-*- coding: ISO-8859-1 -*-


import sqlite3
from scipy.stats import shapiro, ttest_ind

def print_per_line(f, l, n=10):
    for i, c in enumerate(l):
        f.write('%s' % c)
        if (i+1) % n == 0:
            f.write('\n')
        else:
            f.write(' ')

def main():
    con = sqlite3.connect('../prototipo/experimento/db/production.sqlite3')
    c = con.cursor()
    c.execute('select r.stars from ratings r, users u where u.id = r.user_id and u.stage_number >=6')
    #print [ v[0] for v in c.fetchall()]
    print shapiro([ v[0] for v in c.fetchall()])

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
        print rating,algoritmo
        graph.setdefault(algoritmo, [])
        graph[algoritmo].append(rating)
    print graph
    for algoritmo, values in graph.items():
        print_per_line(file('%s.txt' % algoritmo, 'w+'), values)
    print ttest_ind(amigos, nao_amigos)
    
main()
