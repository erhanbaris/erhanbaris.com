---
title: Sanal Makineler
lang: tr
date: 2018-03-21 10:35:12
tags:
 - Sanal-Makine
 - VM
---
Sanal makineler heryerde. Telefonumuzda, bilgisayarımızda, arabamızda, televizyonumuzda. Heryerde. Hemde düşünüldüğü gibi Vmware, VirtualBox, Hyper-V gibi işletim sistemi sanallaştırma gibi kısıtlı bir alanda değil, daha geniş kesimlerce fark etmeden kullanılıyor. Eğer yazılım geliştiriyorsanız yada yazılım ile uğraşıyorsanız emin olun onu kullanıyorsunuz. 
Çoğu programlama dili kendi özel sanal makinesi üzerinde işlemler yapmakta. Bunun belkide en çok bilineni JVM’dir. Yazmış olduğunuz Java kodları derleyiciler ile birlikte opcode’lara çevrilir ve bunu Java Sanal Makinesi yorumlayarak sizin programınızı yürütür. Tabi işlem en basit olarak bu şekilde tanımlanabilir. Diğer yandan MSIL’de aynı şekilde sanala makine üzerinde çalışmakta ve yazmış olduğunuz kodlar sanal makine tarafından yorumlanmakta. JVM yada .Net Platformu dışında Python, Ruby, PHP gibi diğer dillerde performans için sanal makine üzerinde işlemler yapmakta fakat JVM ile ayrılabilecek en önemli noktaları JVM’de opcode’lar JIT derleyicisi ile ilk çalıştırma esnasında makine koduna çevrilmekte ve daha yüksek performans sağlamakta. 

Diller genel olarak işlem yürütme mekanizmasına göre 3'e ayrılıyorlar.
1. AST ile her işlem için yapı tekrar tekrar çalıştırılır.
2. Sanal makineler ile üst düzeyde yazılan kodlar daha hızlı yürütülmek için makine diline benzer ara bir formata çevrilir o şekilde yorumlanır.
3. JIT derleyiciler ile yazılan kodlar çalıştırıldığı ilk anda makine diline çevrilir ve o şekilde çalıştırılır.
4. Son ve en performanslı olan yöntem ile kodlarımız makine diline çevrilir ve böylece en iyi performansı sağlamış olursunuz.

İlkinden sonuncusuna doğru gidildiğinde performans ciddi anlamda artar. Çoğu dil ikinci maddede ki gibi sanal makine üzerinden işlem yaptırmakta. Bende şu anda sadece 2. madde ile ilgileniyorum. 
Sanal makine konsepti kendi içerisinde iki farklı şekilde uygulanıyor. İlki stack tabanlı, ikiniside register tabanlı makineler. Gerçekte buna sanal makineden ziyade sanal cpu olarakta bakılabilir. Assemblr gibi ara bir dile çevirdiğimiz kodları yorumlayarak süreçleri ilerletiyor.
Stack ve register tabanlı sanal makinelerin farklarını kısaca özetlersek;
1. Stack yapısını oluşturmak ve anlamak yazılımcı için daha kolaydır. Register tabanlı sistemlerde yapıyı kurgulamak daha karmaşıktır.
2. Performans olarak register yapısı öne çıkmakta. Bunun nedenide daha az opcode üretilerek daha az işlem ile aynı sonuca ulaşılmaktadır.
3. Register tabanlı sistemde daha az komut kodu vardır.

## DEVAM EDECEK