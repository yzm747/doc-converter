import requests

url = 'https://web-production-4cb75.up.railway.app/api/convert/word-to-pdf'
try:
    with open(r'c:\Users\ZhuanZ（无密码）\WorkBuddy\20260408091252\doc-converter\test.docx', 'rb') as f:
        r = requests.post(url, files={'file': ('test.docx', f, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document')}, timeout=30)
    print(f'Status: {r.status_code}')
    ct = r.headers.get('Content-Type', '')
    print(f'Content-Type: {ct}')
    print(f'Content-Length: {len(r.content)}')
    if r.status_code != 200:
        print(f'Response: {r.text}')
    else:
        print('SUCCESS - Word to PDF conversion works!')
except Exception as e:
    print(f'Error: {e}')
