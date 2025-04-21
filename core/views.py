from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework import viewsets
from .models import Peca
from .serializers import PecaSerializer

class PecaViewSet(viewsets.ModelViewSet):
    queryset = Peca.objects.all()
    serializer_class = PecaSerializer
    parser_classes = (MultiPartParser, FormParser)
