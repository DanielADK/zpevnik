with open('zpevnik.tex', encoding='utf8') as fi:
  for line in fi.readlines():
    if line.startswith('\\input'):
      print(line[(line.index('{')+1):line.index('}')])
