require 'rails_helper'

RSpec.describe Board, type: :model do
  subject { create(:board) }
  let(:ship) { create(:ship) }

  context :associations do
    it { should belong_to(:game).inverse_of(:boards) }
    it { should belong_to(:player) }
    it { should have_many(:board_columns).inverse_of(:board).dependent(:destroy) }
    it { should have_many(:columns).through(:board_columns) }
    it { should have_many(:rows).through(:board_columns) }
  end

  context :instance_methods do
    it 'should place a ship' do
      column = create(:column)
      row = create(:row)

      placement = subject.add_ship_placement!(column, row, ship.ship_type)
      point = subject.board_columns.find_by(column: column, row: row)

      expect(placement).to be_truthy
      expect(point.column.name).to eq(column.name)
      expect(point.row.name).to eq(row.name)
    end

    it 'should place more than one ship' do
      points = create_list(:board_column, 3, board: subject)
      points.each { |point| subject.add_ship_placement!(point.column, point.row, ship.ship_type) }

      expect(subject.board_columns.occupied.count).to eq(3)
    end

    it 'should remove placement' do
      subject.board_columns = create_list(:board_column, 10, board: subject)
      column = subject.board_columns.first.column
      row = subject.board_columns.first.row

      subject.add_ship_placement!(column, row, ship.ship_type)
      expect(subject.board_columns.occupied.count).to eq(1)
      expect(subject.board_columns.unoccupied.count).to eq(9)

      subject.remove_ship_placement!(column, row)
      expect(subject.board_columns.occupied.count).to eq(0)
      expect(subject.board_columns.unoccupied.count).to eq(10)
    end

  end
end
