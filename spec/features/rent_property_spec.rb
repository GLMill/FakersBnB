RSpec.feature 'Viewing property' do

  let(:prop_name){ 'mars mansion'}


 context "user can access properties page and view properties " do
   before {
          add_property(prop_name)
          view_properties
   }

   it 'takes us to the rent properties page' do
     expect(page.current_path).to eq "/rent_property"
     expect(page).to have_content "Here is a list of properties to rent"
   end

   it 'displays list of properties' do
      expect(page).to have_content(prop_name)
   end
 end




end
