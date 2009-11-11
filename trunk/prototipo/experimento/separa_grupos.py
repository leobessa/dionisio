import random
import string

from pprint import pprint
def main():
    content = file('participantes.txt').read()
    grupos = {}
    for i, grupo in enumerate(content.split('\n\n')):
        grupos[i] = filter(None, map(string.strip, grupo.split('\n')))
    todos = set()
    for pessoas in grupos.values():
        todos.update(pessoas)

    pessoas_escolhidos = {}
    pessoas_freq = {}
    for grupo in grupos.values():
        possiveis = todos.symmetric_difference(grupo)
        for pessoa in grupo:
            escolhidos = set()
            while len(escolhidos) < 10:
                candidato = random.choice(list(possiveis))
                pessoas_freq.setdefault(candidato, 0)
                if pessoas_freq[candidato] < 11 and candidato not in escolhidos:
                    escolhidos.add(candidato)
                    pessoas_freq[candidato] += 1
            pessoas_escolhidos[pessoa] = escolhidos
    pprint(pessoas_escolhidos)
    pprint(pessoas_freq)

main()
