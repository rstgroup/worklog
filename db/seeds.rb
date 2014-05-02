# encoding: utf-8

acc = Account.find(2)

mgs = acc.clients.create name: 'MyGreenSpace'
taxi = acc.clients.create name: 'Taxi5'
adgames = acc.clients.create name: 'AdGames'
launch = acc.clients.create name: 'Launch'


mgs_part2 = mgs.projects.create name: 'Część druga'
mgs_part2.parts.create name: 'Specyfikacja'
mgs_part2.parts.create name: 'Wycena'

mgs_add = mgs.projects.create name: 'Dodatkowe funkcjonalności'
mgs_add.parts.create name: 'Specyfikacja'
mgs_add.parts.create name: 'Wycena'

voucher = taxi.projects.create name: 'System voucher'
voucher.parts.create name: 'Specyfikacja'
voucher.parts.create name: 'Makiety'
