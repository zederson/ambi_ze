class Colors::Processor
  @queue = :colors

  def self.perform(ids)
    return false if ids.blank?
    puts "colors: >>>>>>> #{ids}"

    ids.each do |id|
      color = Color.find(id)
      puts "===|| #{color.inspect}"
    end

  end
end
