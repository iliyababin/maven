import '../dao/template_dao.dart';

class TemplateService {
  const TemplateService({
    required TemplateDao templateDao,
  }) : _templateDao = templateDao;

  final TemplateDao _templateDao;


}