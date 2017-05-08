# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-03-20 01:57
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('visitors', '0008_auto_20170319_0729'),
    ]

    operations = [
        migrations.CreateModel(
            name='AlertDelivery',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('alert', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='visitors.Alert')),
                ('record', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='visitors.Visitor')),
                ('subscriber', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='visitors.Subscriber')),
            ],
        ),
    ]