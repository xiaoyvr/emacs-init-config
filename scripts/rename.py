import csv
import os

with open('1wbooks.csv', encoding='utf-8-sig', newline='') as csvfile:
    fieldnames = ['category', 'book_name', 'author']
    reader = csv.DictReader(csvfile, fieldnames, delimiter=',', quotechar='"', strict=True)
    for idx, row in enumerate(reader):
        folder_index = '{:03d}'.format( int(idx / 100) + 1)
        file_index = '{:03d}'.format(idx % 100 + 1)
        book_name = row['book_name'].replace('/', ' ')
        author = row['author'].replace('/', ' ')
        category = row['category']
        series_index = idx + 1
        file_path = f'{folder_index}/{series_index} - {book_name} - {author}.pdf'
        new_file_path = f'{folder_index}/1wbooks - {category} - {series_index} - {book_name} - {author}.pdf'
        os.rename(file_path, new_file_path)
        

        if idx == 9799:
            break


# print(idx, folder_index, file_index, row)
