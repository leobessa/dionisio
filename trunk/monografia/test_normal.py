#!/usr/bin/env python
#-*- coding: utf-8 -*-


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

def tests(title, s1, s2):
    tipos_testes = [
        ('T-Student (t)', ttest_ind(s1, s2)),
        ('Mann-Whitney rank test (u)', (mannwhitneyu(s1, s2)[0], mannwhitneyu(s1, s2)[1]*2)),
        ('Wilcoxon rank-sum test (z)', ranksums(s1, s2)),
        ('Kruskal-Wallis H-test (H)', kruskal(array(s1), array(s2)))
    ]
    
    out = r"""
\begin{table}
\centering
\begin{tabular}{|r|c|c|}
    \hline
    \textbf{Tipo do teste} & \textbf{Valor da estatística} & \textbf{\textit{p}} \\
    \hline
"""
    for teste, (est, p) in tipos_testes:
        out += r"%s & %s & %s \\" % (teste, est, p)
        out += "\n"
        out += r"\hline "
        out += "\n"
    out += """
    \end{tabular}
\caption{\it %s}
\end{table}
""" % title
    print out
    #n = min(len(s1), len(s2))
    #print 'wilcoxon:', wilcoxon(s1[:n], s2[:n])[1]

def main():
    con = sqlite3.connect('../prototipo/experimento/db/production.sqlite3')
    c = con.cursor()
    #c.execute('select r.stars from ratings r, users u where u.id = r.user_id and u.stage_number >=6')
    #print [ v[0] for v in c.fetchall()]
    #print normaltest([ v[0] for v in c.fetchall()])

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
    tests('Teste de que Amigos recomendam melhor do que Desconhecidos (H1)',
            amigos, nao_amigos)
    
    tests('Teste de que recomendações Diretas são melhores que RBC (H1)',
        graph['trust'], diretas)
    
    tests('Teste de que recomendações RBC é melhor que RBP (H1)',
        graph['trust'], graph['profile'])
    
    tests('Teste de que recomendações RBI é melhor que RBC (H1)',
        graph['trust'], graph['item'])
    
main()
