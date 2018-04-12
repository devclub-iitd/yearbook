# -*- coding: utf-8 -*-
# Generated by Django 1.11.12 on 2018-04-11 10:24
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0004_auto_20180410_1903'),
    ]

    operations = [
        migrations.AlterField(
            model_name='poll',
            name='department',
            field=models.CharField(choices=[('biotechnology', 'biotechnology'), ('chemical', 'chemical'), ('civil', 'civil'), ('computer', 'computer'), ('electrical', 'electrical'), ('mathematics', 'mathematics'), ('mechanical', 'mechanical'), ('physics', 'physics'), ('textile', 'textile')], max_length=200),
        ),
        migrations.AlterField(
            model_name='student',
            name='DP',
            field=models.ImageField(blank=True, default='DP/anonymous.png', upload_to='DP'),
        ),
    ]
