require 'rails_helper'

feature 'Admin' do
    scenario 'registers recipe_type' do
        admin = User.create(email: 'patriciapoki@gmail.com', password: '123456', role: :admin)
        login_as(admin, scope: :user)

        visit root_path
        click_on 'Tipos de Receita'
        click_on 'Novo tipo de receita'

        fill_in 'Tipo de receita', with: 'Sobremesa'
        click_on 'Salvar'

        expect(page).to have_content('Novo tipo de receita')
        expect(page).to have_content('Sobremesa')
    end

    scenario 'fails to save recipe_type without filling all fields' do
        admin = User.create(email: 'patriciapoki@gmail.com', password: '123456', role: :admin)
        login_as(admin, scope: :user)

        visit root_path
        click_on 'Tipos de Receita'
        click_on 'Novo tipo de receita'

        fill_in 'Tipo de receita', with: ''
        click_on 'Salvar'

        expect(page).to have_content('Tipo de receita é obrigatório')
    end

    scenario 'cannot register duplicated recipe_type' do
        admin = User.create(email: 'patriciapoki@gmail.com', password: '123456', role: :admin)
        login_as(admin, scope: :user)

        RecipeType.create!(name: 'Café da manhã')

        visit root_path
        click_on 'Tipos de Receita'
        click_on 'Novo tipo de receita'

        fill_in 'Tipo de receita', with: 'Café da manhã'
        click_on 'Salvar'

        expect(page).to have_content('Receitas duplicadas não são permitidas')
        expect(RecipeType.count).to eq(1)
    end
end
