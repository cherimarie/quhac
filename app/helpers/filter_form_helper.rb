module FilterFormHelper
  def expertises
    Provider.all.map{ |p| p.population_expertise }.compact.uniq.reject{ |el| el.empty? }
  end

  def specializations
    Provider.all.map{ |p| p.specialization }.compact.uniq.reject{ |el| el.empty? }
  end
end
