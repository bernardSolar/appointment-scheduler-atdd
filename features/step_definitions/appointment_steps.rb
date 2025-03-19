# Step definitions that use our DSL to interact with the system

# DSL methods that abstract away the implementation details
module AppointmentDSL
  def go_to_booking_page
    visit '/appointments/new'
  end
  
  def enter_appointment_detail(field, value)
    fill_in field_mapping(field), with: value
  end
  
  def submit_appointment_form
    click_button 'Book Appointment'
  end
  
  def go_to_my_appointments
    visit '/appointments'
  end
  
  def field_mapping(field)
    {
      'Date' => 'appointment_date',
      'Time' => 'appointment_time',
      'Description' => 'appointment_description'
    }[field]
  end
  
  def appointment_exists?(details = {})
    # This would check the data store in a real implementation
    AppointmentScheduler::AppointmentStore.exists?(details)
  end
  
  def create_test_appointment(details = {})
    # Set up test data
    AppointmentScheduler::AppointmentStore.add(details)
  end
end

World(AppointmentDSL)

# Step Definitions
Given('I am on the appointment booking page') do
  go_to_booking_page
end

When('I enter appointment details:') do |table|
  @appointment_details = {}
  
  table.hashes.each do |row|
    field = row['Field']
    value = row['Value']
    
    @appointment_details[field.downcase] = value
    enter_appointment_detail(field, value)
  end
end

When('I click the {string} button') do |button_name|
  submit_appointment_form if button_name == 'Book Appointment'
end

Then('I should see a confirmation message') do
  expect(page).to have_content('Appointment booked successfully')
end

Then('the appointment should be stored in the system') do
  expect(appointment_exists?(@appointment_details)).to be true
end

Given('I have previously booked an appointment') do
  @test_appointment = {
    'date' => '2025-04-01',
    'time' => '14:00',
    'description' => 'Doctor appointment'
  }
  create_test_appointment(@test_appointment)
end

When('I navigate to the {string} page') do |page_name|
  go_to_my_appointments if page_name == 'My Appointments'
end

Then('I should see my appointment in the list with correct details') do
  expect(page).to have_content(@test_appointment['date'])
  expect(page).to have_content(@test_appointment['time'])
  expect(page).to have_content(@test_appointment['description'])
end