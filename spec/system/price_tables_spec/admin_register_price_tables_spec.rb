require 'rails_helper'

# describe 'Usuário tenta cadastrar linha em tabela de preços' do
#     it 'e não encontra o botão quando não é admin' do
#         # Arrange
#         user = FactoryBot.create(:user)


#         # Act
#         login_as(user)
#         visit root_path
#         click_on('Tabelas de Preço')

#         # Assert
#         expect(page).not_to have_link 'Adicionar linha à tabela de Peso'
#         expect(page).not_to have_link 'Adicionar linha à tabela de Distância'

#     end
#     it 'e acessa a pagina de adicionar linha a uma tabela de peso vazia' do
#         # Arrange
#         user = FactoryBot.create(:user, admin: true)


#         # Act
#         login_as(user)
#         visit price_tables_path
#         click_on 'Adicionar linha à tabela de Peso'

#         # Assert
#         expect(page).to have_field 'Peso Mínimo'
#         expect(page).to have_field 'Peso Máximo'
#         expect(page).to have_field 'Valor por Peso'

#     end
#     it 'e acessa a pagina de adicionar linha a uma tabela de peso com um cadastro' do
#         # Arrange
#         user = FactoryBot.create(:user, admin: true)
#         FactoryBot.create(:weight_table, min: 0, max: 20, value: 0.8)

#         # Act
#         login_as(user)
#         visit price_tables_path
#         click_on 'Adicionar linha à tabela de Peso'

#         # Assert
#         expect(page).to have_content '0kg'
#         expect(page).to have_content '20kg'
#         expect(page).to have_content 'R$ 0,80'
#         expect(page).to have_field 'Peso Mínimo'
#         expect(page).to have_field 'Peso Máximo'
#         expect(page).to have_field 'Valor por Peso'

#     end
#     it 'e adiciona a linha a uma tabela de peso vazia com sucesso' do
#         # Arrange
#         user = FactoryBot.create(:user, admin: true)


#         # Act
#         login_as(user)
#         visit price_tables_path
#         click_on 'Adicionar linha à tabela de Peso'
#         fill_in 'Peso Mínimo', with: 0
#         fill_in 'Peso Máximo', with: 20
#         fill_in 'Valor por Peso', with: 0.80
#         click_on 'Enviar'

#         # Assert

#         expect(page).to have_content('Linha 1 adicionada com sucesso.')
#         expect(page).to have_content 'Intervalo de pesos'
#         expect(page).to have_content 'Preço por kg'
#         expect(page).to have_content '0kg'
#         expect(page).to have_content '20kg'
#         expect(page).to have_content 'R$ 0,80'
#     end
#     it 'e acessa a pagina de adicionar linha a uma tabela de distância vazia' do
#         # Arrange
#         user = FactoryBot.create(:user, admin: true)


#         # Act
#         login_as(user)
#         visit price_tables_path
#         click_on 'Adicionar linha à tabela de Distância'

#         # Assert
#         expect(page).to have_field 'Distância Mínima'
#         expect(page).to have_field 'Distância Máxima'
#         expect(page).to have_field 'Valor por Distância'

#     end
#     it 'e acessa a pagina de adicionar linha a uma tabela de Distãncia com um cadastro' do
#         # Arrange
#         user = FactoryBot.create(:user, admin: true)
#         FactoryBot.create(:distance_table, min: 0, max:20, value: 0.8)

#         # Act
#         login_as(user)
#         visit price_tables_path
#         click_on 'Adicionar linha à tabela de Distância'

#         # Assert
#         expect(page).to have_content '0km'
#         expect(page).to have_content '20km'
#         expect(page).to have_content 'R$ 0,80'
#         expect(page).to have_field 'Distância Mínima'
#         expect(page).to have_field 'Distância Máxima'
#         expect(page).to have_field 'Valor por Distância'

#     end
#     it 'e adiciona a linha a uma tabela de distância vazia com sucesso' do
#         # Arrange
#         user = FactoryBot.create(:user, admin: true)


#         # Act
#         login_as(user)
#         visit price_tables_path
#         click_on 'Adicionar linha à tabela de Distância'
#         fill_in 'Distância Mínima', with: 0
#         fill_in 'Distância Máxima', with: 10
#         fill_in 'Valor por Distância', with: 0.65
#         click_on 'Enviar'

#         # Assert

#         expect(page).to have_content('Linha 1 adicionada com sucesso.')
#         expect(page).to have_content 'Intervalo de distâncias'
#         expect(page).to have_content 'Preço por km'
#         expect(page).to have_content '0km'
#         expect(page).to have_content '10km'
#         expect(page).to have_content 'R$ 0,65'
#     end
# end
