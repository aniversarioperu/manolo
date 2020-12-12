# Generated by Django 2.2.13 on 2020-12-06 18:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('visitors', '0019_auto_20201206_0403'),
    ]

    operations = [
        migrations.CreateModel(
            name='Institution',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('slug', models.CharField(max_length=200, unique=True)),
                ('name', models.CharField(max_length=200, unique=True)),
                ('rank', models.IntegerField()),
            ],
        ),
    ]