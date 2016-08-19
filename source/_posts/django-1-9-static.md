---
title: django-html-static
date: 2016-07-16 16:32:10
tags: django
categories: django
---
在学习[django教程](http://djangobook.py3k.cn/2.0/)的时候,想要在模板中引入css,js等静态文件,鼓捣了有一天多,终于在[stackoverflow](http://stackoverflow.com/questions/15491727/include-css-and-javascript-in-my-django-template)找到教程,现开始贴代码,记录一下.

## 首先在根目录下新建一个staticfiles文件,里面存放需要的各种css,js等文件.

## 然后设置setting.py:
<!--more-->
<pre><code>
	PROJECT_DIR = os.path.dirname(__file__)
	MEDIA_ROOT = os.path.join(PROJECT_DIR, 'media')

	MEDIA_URL = '/media/'
	STATIC_ROOT = os.path.join(PROJECT_DIR, 'static')

	STATIC_URL = '/static/'

	STATICFILES_DIRS = (
    os.path.join(PROJECT_DIR, 'staticfiles'),
	)
</pre></code>

## url.py:

<pre><code>
	from django.conf.urls import patterns, include, url

	from django.conf.urls.static import static

	from django.contrib.staticfiles.urls import staticfiles_urlpatterns

	from mysite import settings

	admin.autodiscover()

	urlpatterns = patterns('',('^$', hello),

	url(r'^dance/$', dance),

	) + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

	urlpatterns += staticfiles_urlpatterns()

</pre></code>

## templates文件夹下的模板文件:

![模板](../../../../imgs/django-html.png)


新手上路,一起交流



