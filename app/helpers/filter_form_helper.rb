module FilterFormHelper
  def expertises
    Provider.all.map{ |p| p.population_expertise }.compact.uniq.reject{ |el| el.empty? }
  end

  def specializations
    Provider.all.map{ |p| p.specialization }.compact.uniq.reject{ |el| el.empty? }
  end

  def gender_identities
    Provider.all.map{ |p| p.gender_id.downcase if p.gender_id }.compact.uniq.reject{ |el| el.empty? }
  end

  def orientations
    Provider.all.map{ |p| p.orientation }.compact.uniq.reject{ |el| el.empty? }
  end

  def prov_types
    Provider.all.map{ |p| p.type }.compact.uniq.reject{ |el| el.empty? }
  end
end
