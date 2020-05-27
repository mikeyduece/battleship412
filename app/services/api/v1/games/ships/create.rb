class Api::V1::Games::Ships::Create < BaseGameService

  def call(&block)
    yield(Success.new(game), NoTrigger)

  rescue StandardError => e
    yield(NoTrigger, Failure.new(e.message), 500)
  end

  private

  def place_ships
    ships.each do |ship, coords|
      ship_board.place_ships!(ship, coords)
    end
  end

end