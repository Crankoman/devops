# Домашнее задание к занятию "2.4. Инструменты Git"

------

## 1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.

<-

    git show 'aefea'
    commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
    Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
    Date:   Thu Jun 18 10:29:58 2020 -0400
    Update CHANGELOG.md

ПОЛНЫЙ ХЕШ - ***aefead2207ef7e2aa5dc81a34aedf0cad4c32545***

------

## 2. Какому тегу соответствует коммит 85024d3?

<-

    git show '85024d3'
    commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)
    Author: tf-release-bot <terraform@hashicorp.com>
    Date:   Thu Mar 5 20:56:10 2020 +0000

ТЕГ -  ***v0.12.23***


------

## 3. Сколько родителей у коммита b8d720? Напишите их хеши.

<-
Получаем информацию о коммите b8d720 %P - хеши родительских элементов

    git show 'b8d720' --pretty=%P

Результат

    56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b

Полные хеши родителей ***56cd7859e05c36c06b56d013b55a252d0bb7e158*** и ***9ea88f22fc6269854151c571162c5bcf958bee2b***

------

## 4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.

<-
Получаем информацию о коммитах сделанных между тегами v0.12.23 и v0.12. %H - полный хеш, %s - текст коммита 

     git log v0.12.23..v0.12.24 --pretty=%H-%s

Результат

     33ff1c03bb960b332be3af2e333462dde88b279e-v0.12.24
     b14b74c4939dcab573326f4e3ee2a62e23e12f89-[Website] vmc provider links
     3f235065b9347a758efadc92295b540ee0a5e26e-Update CHANGELOG.md
     6ae64e247b332925b872447e9ce869657281c2bf-registry: Fix panic when server is unreachable
     5c619ca1baf2e21a155fcdb4c264cc9e24a2a353-website: Remove links to the getting started guide's old location
     06275647e2b53d97d4f0a19a0fec11f6d69820b5-Update CHANGELOG.md
     d5f9411f5108260320064349b757f55c09bc4b80-command: Fix bug when using terraform login on Windows
     4b6d06cc5dcb78af637bbb19c198faff37a066ed-Update CHANGELOG.md
     dd01a35078f040ca984cdd349f18d0b67e486c35-Update CHANGELOG.md
     225466bc3e5f35baa5d07197bbc079345b77525e-Cleanup after v0.12.23 release
     

------   

## 5. Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточия перечислены аргументы).
<-
Ищем где объявляется функция func providerSource(...) через git grep, где -E использовать расширенный синтаксис регулярных выражений \( и \) экранируем скобки
      
    git grep -E 'func providerSource\(.*\)'
Результат

    provider_source.go:func providerSource(configs []*cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {
Видим что функция объявляется в provider_source.go. Ищем коммит в котором она была создана используем --reverse, что бы показывать сначала самые ранние коммиты, -L для поиска функций в файле, %h для вывода короткого хеша
    
    git log --reverse -L':func providerSource':provider_source.go --pretty=%h
Результат
<details>                         
    <summary>подробнее</summary> 

    8c928e8358-Thu Apr 2 18:04:39 2020 -0700
    
    diff --git a/provider_source.go b/provider_source.go
    --- /dev/null
    +++ b/provider_source.go
    @@ -0,0 +19,5 @@
    +func providerSource(services *disco.Disco) getproviders.Source {
    +	// We're not yet using the CLI config here because we've not implemented
    +	// yet the new configuration constructs to customize provider search
    +	// locations. That'll come later.
    +	// For now, we have a fixed set of search directories:
    92d6a30bb4-Wed Apr 15 11:48:24 2020 -0700
    
    diff --git a/provider_source.go b/provider_source.go
    --- a/provider_source.go
    +++ b/provider_source.go
    @@ -19,5 +20,6 @@
     func providerSource(services *disco.Disco) getproviders.Source {
     	// We're not yet using the CLI config here because we've not implemented
     	// yet the new configuration constructs to customize provider search
    -	// locations. That'll come later.
    -	// For now, we have a fixed set of search directories:
    +	// locations. That'll come later. For now, we just always use the
    +	// implicit default provider source.
    +	return implicitProviderSource(services)
    5af1e6234a-Tue Apr 21 16:28:59 2020 -0700
    
    diff --git a/provider_source.go b/provider_source.go
    --- a/provider_source.go
    +++ b/provider_source.go
    @@ -20,6 +23,15 @@
    -func providerSource(services *disco.Disco) getproviders.Source {
    -	// We're not yet using the CLI config here because we've not implemented
    -	// yet the new configuration constructs to customize provider search
    -	// locations. That'll come later. For now, we just always use the
    -	// implicit default provider source.
    -	return implicitProviderSource(services)
    +func providerSource(configs []*cliconfig.ProviderInstallation, services *disco.Disco) (getproviders.Source, tfdiags.Diagnostics) {
    +	if len(configs) == 0 {
    +		// If there's no explicit installation configuration then we'll build
    +		// up an implicit one with direct registry installation along with
    +		// some automatically-selected local filesystem mirrors.
    +		return implicitProviderSource(services), nil
    +	}
    +
    +	// There should only be zero or one configurations, which is checked by
    +	// the validation logic in the cliconfig package. Therefore we'll just
    +	// ignore any additional configurations in here.
    +	config := configs[0]
    +	return explicitProviderSource(config, services)
    +}
    +
</details>

В коммите ***8c928e8358*** и была создана функция  func providerSource()

------   

## 6. Найдите все коммиты в которых была изменена функция globalPluginDirs.

<-
Ищем как объявлена функция globalPluginDirs

     git grep globalPluginDirs

Результат  

     commands.go:            GlobalPluginDirs: globalPluginDirs(),
     commands.go:    helperPlugins := pluginDiscovery.FindPlugins("credentials", globalPluginDirs())
     internal/command/cliconfig/config_unix.go:              // FIXME: homeDir gets called from globalPluginDirs during init, before
     plugins.go:// globalPluginDirs returns directories that should be searched for
     plugins.go:func globalPluginDirs() []string {

Видим что функция объявляется в plugins.go через 'func globalPluginDirs('

Получаем информацию об изменениях  'func globalPluginDirs' в файле plugins.go  %h-короткий хеш 

     git log -L':func globalPluginDirs':plugins.go --pretty=%h

Результат
<details>
    <summary>подробнее</summary>
    
    78b1220558 
    
    diff --git a/plugins.go b/plugins.go
    --- a/plugins.go
    +++ b/plugins.go
    @@ -16,14 +18,14 @@
     func globalPluginDirs() []string {
     	var ret []string
     	// Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
    -	dir, err := ConfigDir()
    +	dir, err := cliconfig.ConfigDir()
     	if err != nil {
     		log.Printf("[ERROR] Error finding global config directory: %s", err)
     	} else {
     		machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH)
     		ret = append(ret, filepath.Join(dir, "plugins"))
     		ret = append(ret, filepath.Join(dir, "plugins", machineDir))
     	}
     
     	return ret
     }
    52dbf94834
    
    diff --git a/plugins.go b/plugins.go
    --- a/plugins.go
    +++ b/plugins.go
    @@ -16,13 +16,14 @@
     func globalPluginDirs() []string {
     	var ret []string
     	// Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
     	dir, err := ConfigDir()
     	if err != nil {
     		log.Printf("[ERROR] Error finding global config directory: %s", err)
     	} else {
     		machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH)
    +		ret = append(ret, filepath.Join(dir, "plugins"))
     		ret = append(ret, filepath.Join(dir, "plugins", machineDir))
     	}
     
     	return ret
     }
    41ab0aef7a
    
    diff --git a/plugins.go b/plugins.go
    --- a/plugins.go
    +++ b/plugins.go
    @@ -14,12 +16,13 @@
     func globalPluginDirs() []string {
     	var ret []string
     	// Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
     	dir, err := ConfigDir()
     	if err != nil {
     		log.Printf("[ERROR] Error finding global config directory: %s", err)
     	} else {
    -		ret = append(ret, filepath.Join(dir, "plugins"))
    +		machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH)
    +		ret = append(ret, filepath.Join(dir, "plugins", machineDir))
     	}
     
     	return ret
     }
    66ebff90cd
    
    diff --git a/plugins.go b/plugins.go
    --- a/plugins.go
    +++ b/plugins.go
    @@ -16,22 +14,12 @@
     func globalPluginDirs() []string {
     	var ret []string
    -
    -	// Look in the same directory as the Terraform executable.
    -	// If found, this replaces what we found in the config path.
    -	exePath, err := osext.Executable()
    -	if err != nil {
    -		log.Printf("[ERROR] Error discovering exe directory: %s", err)
    -	} else {
    -		ret = append(ret, filepath.Dir(exePath))
    -	}
    -
     	// Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
     	dir, err := ConfigDir()
     	if err != nil {
     		log.Printf("[ERROR] Error finding global config directory: %s", err)
     	} else {
     		ret = append(ret, filepath.Join(dir, "plugins"))
     	}
     
     	return ret
     }
    8364383c35
    
    diff --git a/plugins.go b/plugins.go
    --- /dev/null
    +++ b/plugins.go
    @@ -0,0 +16,22 @@
    +func globalPluginDirs() []string {
    +	var ret []string
    +
    +	// Look in the same directory as the Terraform executable.
    +	// If found, this replaces what we found in the config path.
    +	exePath, err := osext.Executable()
    +	if err != nil {
    +		log.Printf("[ERROR] Error discovering exe directory: %s", err)
    +	} else {
    +		ret = append(ret, filepath.Dir(exePath))
    +	}
    +
    +	// Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX
    +	dir, err := ConfigDir()
    +	if err != nil {
    +		log.Printf("[ERROR] Error finding global config directory: %s", err)
    +	} else {
    +		ret = append(ret, filepath.Join(dir, "plugins"))
    +	}
    +
    +	return ret
    +}
</details>

В результате видим коммит с хешем ***8364383c35***  в котором создается функция globalPluginDirs, в коммитах: ***78b1220558, 52dbf94834, 41ab0aef7a, 66ebff90cd*** она изменяется.

------  

## 7.Кто автор функции synchronizedWriters?
<-
Используем git log, используем --reverse, что бы показывать сначала самые ранние коммиты, -S для поиска вхождения строки, %h- короткий хеш %ad-дата автора %an-имя автора %ae-email автора %s- текст коммита -p - подробная история изменения

    git log --reverse -S'func synchronizedWriters' --pretty=%h-%ad-%an-%ae-%s -p
Результат 
<details>                             
    <summary>подробнее</summary>

    5ac311e2a9-Wed May 3 16:25:41 2017 -0700-Martin Atkins-mart@degeneration.co.uk-main: synchronize writes to VT100-faker on Windows

    diff --git a/synchronized_writers.go b/synchronized_writers.go
    new file mode 100644
    index 0000000000..2533d1316c
    --- /dev/null
    +++ b/synchronized_writers.go
    @@ -0,0 +1,31 @@
    +package main
    +
    +import (
    +       "io"
    +       "sync"
    +)
    +
    +type synchronizedWriter struct {
    +       io.Writer
    +       mutex *sync.Mutex
    +}
    +
    +// synchronizedWriters takes a set of writers and returns wrappers that ensure
    +// that only one write can be outstanding at a time across the whole set.
    +func synchronizedWriters(targets ...io.Writer) []io.Writer {
    +       mutex := &sync.Mutex{}
    +       ret := make([]io.Writer, len(targets))
    +       for i, target := range targets {
    +               ret[i] = &synchronizedWriter{
    +                       Writer: target,
    +                       mutex:  mutex,
    +               }
    +       }
    +       return ret
    +}
    +
    +func (w *synchronizedWriter) Write(p []byte) (int, error) {
    +       w.mutex.Lock()
    +       defer w.mutex.Unlock()
    +       return w.Writer.Write(p)
    +}
    bdfea50cc8-Mon Nov 30 18:02:04 2020 -0500-James Bardin-j.bardin@gmail.com-remove unused
    
    diff --git a/synchronized_writers.go b/synchronized_writers.go
    deleted file mode 100644
    index 2533d1316c..0000000000
    --- a/synchronized_writers.go
    +++ /dev/null
    @@ -1,31 +0,0 @@
    -package main
    -
    -import (
    -       "io"
    -       "sync"
    -)
    -
    -type synchronizedWriter struct {
    -       io.Writer
    -       mutex *sync.Mutex
    -}
    -
    -// synchronizedWriters takes a set of writers and returns wrappers that ensure
    -// that only one write can be outstanding at a time across the whole set.
    -func synchronizedWriters(targets ...io.Writer) []io.Writer {
    -       mutex := &sync.Mutex{}
    -       ret := make([]io.Writer, len(targets))
    -       for i, target := range targets {
    -               ret[i] = &synchronizedWriter{
    -                       Writer: target,
    -                       mutex:  mutex,
    -               }
    -       }
    -       return ret
    -}
    -
    -func (w *synchronizedWriter) Write(p []byte) (int, error) {
    -       w.mutex.Lock()
    -       defer w.mutex.Unlock()
    -       return w.Writer.Write(p)
    -}
</details>

В результате видим коммит с хешем ***5ac311e2a9*** от 3 мая 2017 где Martin Atkins-mart@degeneration.co.uk создал данную функцию.
30 ноября 2020 James Bardin-j.bardin@gmail.com удалили данную функцию как не используемую в коммите ***bdfea50cc8*** 