require_relative '../lib/menu.rb'
describe 'Testing the menu choices' do
  menu = Menu.new
  ###
  # The following test have to be done in order to work
  ###
  it "should display 'Start typing' as the first menu option" do
    expect(menu.menu_selection).to eq('1')
  end
  it "should display 'Start targeted typing practice' as the second menu option" do
    expect(menu.menu_selection).to eq('2')
  end
  it "should display 'Display your typing statistics' as the third menu option" do
    expect(menu.menu_selection).to eq('3')
  end
  it "should display 'Reset your typing statistics' as the fourth menu option" do
    expect(menu.menu_selection).to eq('4')
  end
  it "should display 'Exit' as the fifth menu option" do
    expect(menu.menu_selection).to eq('5')
  end
end
