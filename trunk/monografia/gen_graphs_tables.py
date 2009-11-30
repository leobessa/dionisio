#!/usr/bin/env python

import jinja2
from tempfile import NamedTemporaryFile

def run(cmd):
    import subprocess
    return subprocess.Popen(cmd,stdout=subprocess.PIPE).communicate()[0]

def call_script(input, output):
    out = run(['./bargraph.pl', '-pdf', input])
    file(output,'w+').write(out)

def gen_bar(x_labels, graph, out_name):
    conf = NamedTemporaryFile()
    conf.write('=cluster;%s\n' % ';'.join(x_labels))
    conf.write('=table\n')
    for x, y_list in graph.items():
        columns = ' '.join(map(str, y_list))
        conf.write('%s %s\n' % (x, columns))
    conf.flush()
    call_script(conf.name, out_name)
    conf.close()
        
def main():
    graph = {'teste': [1, 2], 'oi': [4,5]}
    gen_bar(['col1', 'col2'], graph, 'teste.pdf')


main()
