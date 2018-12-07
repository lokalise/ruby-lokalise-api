require 'base64'
require 'dotenv/load'

lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-lokalise-api'

@client = Lokalise.client ENV['LOKALISE_API_TOKEN']
puts @client.keys('803826145ba90b42d5d860.46800099').inspect
# puts @client.create_comments('803826145ba90b42d5d860.46800099', '13207975',
#                              {
#                                comment: 'demo'
#                              }).inspect
# {comment: 'test'}).inspect
#
# r = @client.create_contributors('803826145ba90b42d5d860.46800099',
#
#                                   {
#                                     email: 'test@example.com',
#                                     languages: [{lang_iso: 'en'}]
#                                   })
# puts r.inspect
# puts r.email

# puts @client.create_screenshots('803826145ba90b42d5d860.46800099',
#                                {
# data: 'data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAH0AAAAgCAIAAACw8uBbAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAASdEVYdFNvZnR3YXJlAEdyZWVuc2hvdF5VCAUAAALkSURBVGhD7ZnNattAEIDzAO65r+CWtNCrqWUby01SHISVCqMeQujBhda0hlx8co6pDy0Un9pT60AuPRZKUK59APeNOquR5NXoZ7XyOnJgzYeQRrOzu99uJIj2Hjwycnj42PjZ7P1pH8DxSdOafflGIPlArf7u0rsem00Sz6d2uvCuLp7VJVuxvrzb8Od5C0uyAo/12SsxBkS2rcA7sP+0DdLhSOJZyHqvmRc/PPhJL5USavVX46tg5WSXbZO2Yu+abaC9V8Pe81ZHc/do79WgvVeDhPf351M4Xi6+8/AJmuIU9Q7S0TIvHSOaEhTyjtLRcmQ8imhKIPYeSUfL0XkU2QUaxtFy5MzNNomXQGGpHKTfq/fduzBzV7wT0QSSXBXaO4zbnJ+5/96+BpZ9NnoSwYktXWc1GkyMdsM8vhmxu3jJ8uORQIQ9wAo3tplVc94PGmIOX4pLCy5X7hHm+NXWQ/rYPEwtpRbp54x1MhR47w/iU2KC+NHj5EN9vi9/c0FDCGZEXKzJiuNi0F78nLPjId5aL5gbrD1bAFaWr0+ac0MKS4Wt+GQlZHr/1O39PThMAnHypiXgFotE+5fBRg4i3Mz5/Yh7MCXC54fntJfMnHXXE5etAZ8Zkdocb2ErPFdIpneim+elNcjxjgxtB6yxeYq9x+/m58elrHtJy9ncO/6x3qn3adckuhGIT6YzoXcApPhPidTnDD/J5N38/Ji1sJeUHCyF1qI1yM7kg8EAkptAFXnP968mfdRAZPThPJKe6h0er8EjIhwxzgSDyR3nzy32riORhBTfVLyX1By+1IrrETY+qZxsDu9YrL+NzQ4I3qu/ei8i6XDunr7hpad61xRB4N1sdX776uFoWzaRDpB8TUEE3gGn0wXpcCRxzSaIvWu2gfZeDdp7NWjv1aC9V4OEd/19VSFFvevvq2op5F1/X1WO2PvufF9tGOOFdz1zFPzDRGGpcki/V++Fd2Fmxd5bnf90pEGocXtKKgAAAABJRU5ErkJggg==',
# title: 'test screen'
#                                }).inspect
#
# puts @client.create_task('803826145ba90b42d5d860.46800099',
#                          {
#                            title: 'demo 2',
#                            keys: ['15305182'],
#                            languages: [
#                              {
#                                language_iso: 'ru',
#                                users: ['20181']
#                              }
#                            ]
#                          }).inspect
# puts @client.projects.inspect

# puts @client.files('803826145ba90b42d5d860.46800099').inspect

# puts @client.keys('803826145ba90b42d5d860.46800099').inspect
