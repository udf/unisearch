import urllib.request

print('Downloading UnicodeData.txt...')
urllib.request.urlretrieve('ftp://ftp.unicode.org/Public/UNIDATA/UnicodeData.txt', 'UnicodeData.txt')

print('Parsing data...')
new_lines = []
with open('UnicodeData.txt') as f:
    for line in f:
        code_val, char_name, _ = line.split(';', 2)
        if char_name.startswith('<'):
            continue
        if len(code_val) > 4:
            code_val = code_val.zfill(6)
        char = chr(int(code_val, 16))
        new_lines.append(f'\u202d{char} {char_name}; U+{code_val}')

print('Writing UnicodeChars.txt...')
with open('UnicodeChars.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(new_lines))
