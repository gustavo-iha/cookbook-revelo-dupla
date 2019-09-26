require 'rails_helper'

feature 'Admin' do
    scenario 'registers recipe_type' do
        visit root_path
        click_on 'Admin - tipos de receitas'
        click_on 'Novo tipo de receita'

        fill_in 'Tipo de receita', with: 'Sobremesa'
        click_on 'Salvar'

        expect(page).to have_content('Novo tipo de receita')
        expect(page).to have_content('Sobremesa')
    end

    scenario 'fails to save recipe_type without filling all fields' do
        visit root_path
        click_on 'Admin - tipos de receitas'
        click_on 'Novo tipo de receita'

        fill_in 'Tipo de receita', with: ''
        click_on 'Salvar'

        expect(page).to have_content('Tipo de receita é obrigatório')
    end

    scenario 'cannot register duplicated recipe_type' do
        RecipeType.create!(name: 'Café da manhã')

        visit root_path
        click_on 'Admin - tipos de receitas'
        click_on 'Novo tipo de receita'

        fill_in 'Tipo de receita', with: 'Café da manhã'
        click_on 'Salvar'

        expect(page).to have_content('Receitas duplicadas não são permitidas')
        expect(RecipeType.count).to eq(1)
    end
end
